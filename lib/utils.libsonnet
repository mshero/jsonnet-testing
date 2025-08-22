////////////////////////////////////////////////////////////////////////////////
// Load Test Automation Utils - Jsonnet Library
//
// The utils.libsonnet provides common utility methods for convenient use.

local optionalArgument(name, value) =
  assert std.isString(name) && std.length(name) > 0 : 'argument name must be provided';
  if std.type(value) != 'null' && std.length(std.toString(value)) > 0 then
    [name + '=' + std.toString(value)]
  else
    [];

{
  optionalArgument: optionalArgument,
}
