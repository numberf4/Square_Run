
local GGData = {}
local GGData_mt = { __index = GGData }

local json = require( "json" )
local lfs = require( "lfs" )
local crypto = require( "crypto" )

-------- Functions used for converting tables to strings which is used for data integrity. Functions sourced from here - http://lua-users.org/wiki/TableUtils
function table.val_to_str ( v )
	if "string" == type( v ) then
		v = string.gsub( v, "\n", "\\n" )
		if string.match( string.gsub(v,"[^'\"]",""), '^"+$' ) then
			return "'" .. v .. "'"
		end
		return '"' .. string.gsub(v,'"', '\\"' ) .. '"'
	else
		return "table" == type( v ) and table.tostring( v ) or tostring( v )
	end
end

function table.key_to_str ( k )
	if "string" == type( k ) and string.match( k, "^[_%a][_%a%d]*$" ) then
		return k
	else
		return "[" .. table.val_to_str( k ) .. "]"
	end
end

function table.tostring( tbl )
	local result, done = {}, {}
	for k, v in ipairs( tbl ) do
		table.insert( result, table.val_to_str( v ) )
		done[ k ] = true
	end
	for k, v in pairs( tbl ) do
		if not done[ k ] then
	  		table.insert( result,
			table.key_to_str( k ) .. "=" .. table.val_to_str( v ) )
		end
	end
	return "{" .. table.concat( result, "," ) .. "}"
end

local toString = function( value )
	if type( value ) == "table" then
		return table.tostring( value )
	else
		return tostring( value )
	end
end
-----------------------------------------------
function GGData:new( id, path, baseDir )

    local self = {}

    setmetatable( self, GGData_mt )

    self.id = id
    self.path = path or "boxes"
    self.baseDir = baseDir

    if self.id then
    	self:load()
    end

    return self

end

function GGData:load( id, path, baseDir )

	-- Set up the path
	path = path or "boxes"


	local box

	-- If no id was passed in then assume we're working with a pre-loaded GGData object so use its id
	if not id then
		id = self.id
		box = self
	end

	local data = {}

	local path = system.pathForFile( path .. "/" .. id .. ".box", baseDir or system.DocumentsDirectory )

	local file = io.open( path, "r" )

	if not file then
		return
	end

	data = json.decode( file:read( "*a" ) )
	io.close( file )

	-- If no GGData exists then we are acting on a Class function i.e. not a pre-loaded GGData object.
	if not box then
		-- Create the new GGData object.
		box = GGData:new()
	end

	-- Copy all the properties across.
	for k, v in pairs( data ) do
		box[ k ] = v
	end

	return box

end

function GGData:save()

	-- Don't want this key getting saved out
	local integrityKey = self.integrityKey
	self.integrityKey = nil

	local data = {}

	-- Copy across all the properties that can be saved.
	for k, v in pairs( self ) do
		if type( v ) ~= "function" and type( v ) ~= "userdata" then
			data[ k ] = v
		end
	end

	-- Check for and create if necessary the boxes directory.
	local path = system.pathForFile( "", system.DocumentsDirectory )
	local success = lfs.chdir( path )

	if success then
		lfs.mkdir( self.path )
		path = self.path
	else
		path = ""
	end

	data = json.encode( data )

	path = system.pathForFile( self.path .. "/" .. self.id .. ".box", system.DocumentsDirectory )
	local file = io.open( path, "w" )

	if not file then
		return
	end

	file:write( data )

	io.close( file )
	file = nil

	-- Set the key back again
	self.integrityKey = integrityKey

end

function GGData:set( name, value )
	self[ name ] = value
	self:storeIntegrityHash( name, value )
end


function GGData:get( name )
	return self[ name ] or self[ tostring( name) ]
end


function GGData:clear()
	for k, v in pairs( self ) do
		if k ~= "integrityControlEnabled"
			and k ~= "integrityAlgorithm"
			and k ~= "integrityKey"
			and k ~= "id"
			and k ~= "path"
			and type( k ) ~= "function" then
				self[ k ] = nil
		end
	end
end


function GGData:storeIntegrityHash( name, value )

	if not self.integrityControlEnabled then
		return
	end

	value = value or self[ name ]

	self.hash = self.hash or {}

	if value then
		self.hash[ name ] = crypto.hmac( self.integrityAlgorithm, toString( value ), self.integrityKey, false )
	end

end


function GGData:verifyIntegrity()

	if not self.integrityControlEnabled then
		return
	end

	local corruptEntries = {}

	for k, v in pairs( self ) do
		if k ~= "integrityControlEnabled"
			and k ~= "integrityAlgorithm"
			and k ~= "integrityKey"
			and k ~= "hash"
			and k ~= "id"
			and k ~= "path"
			and toString( v ) then

				if not self:verifyItemIntegrity( k, v ) then
					corruptEntries[ #corruptEntries + 1 ] = { name = k, value = v }
					self[ k ] = nil
					self.hash[ k ] = nil
				end
		end
	end

	for k, v in pairs( self.hash ) do
		if not self[ k ] then
			corruptEntries[ #corruptEntries + 1 ] = { name = k, value = v }
			self[ k ] = nil
			self.hash[ k ] = nil
		end
	end

	return corruptEntries

end


function GGData:getFilename()
	local relativePath = self.path .. "/" .. self.id .. ".box"
	local fullPath = system.pathForFile( relativePath, system.DocumentsDirectory )
	return fullPath, relativePath
end

function GGData:destroy()
	self:clear()
	self = nil
end

return GGData
