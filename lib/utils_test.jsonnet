////////////////////////////////////////////////////////////////////////////////
// Load Test Automation Utils - Unit Tests

local test = import '../vendor/jsonnetunit/jsonnetunit/test.libsonnet';
local utils = import 'utils.libsonnet';


test.suite({
  testOptionalArgumentValueNull: {
    actual: utils.optionalArgument('name', null),
    expect: [],
  },
  testOptionalArgumentValueNumber: {
    actual: utils.optionalArgument('name', 123),
    expect: ['name=123'],
  },
  testOptionalArgumentValueString: {
    actual: utils.optionalArgument('name', '456'),
    expect: ['name=456'],
  },
  testOptionalArgumentValueObject: {
    actual: utils.optionalArgument('name', { attr: 'val' }),
    expect: ['name={"attr": "val"}'],
  },
  testOptionalArgumentValueStringList: {
    actual: utils.optionalArgument('name', ['one', 'two', 'three']),
    expect: ['name=["one", "two", "three"]'],
  },
  testOptionalArgumentValueNumberList: {
    actual: utils.optionalArgument('name', [1, 2, 3]),
    expect: ['name=[1, 2, 3]'],
  },
})
