require('luarocks.require')
require('telescope')
require('lusp')

context('Lusp', function()

  context('atom(token)', function()
    test('Returns "number" for numbers', function()
      assert_type(atom('666'), 'number')
    end)

    test('Returns "string" for others', function()
      assert_type(atom('text'), 'string')
    end)
  end)

  context('env:find(var)', function()
    test('', function()
      -- TODO  
    end)
  end)

  context('read_from(tokens)', function()
    test('', function()
    -- TODO
    end)
  end)

  context('isa(o, t)', function()
    test('', function()
    -- TODO
    end)
  end)

  context('eval(x)', function()
    test('', function()
    -- TODO
    end)
  end)

  context('map(f, t)', function()
    test('', function()
    -- TODO
    end)
  end)

  context('pop(t)', function()
    test('', function()
    -- TODO
    end)
  end)

  context('tokenize(s)', function()
    test('(10) has three tokens: "(", "10" and ")"', function()
      local tokens = tokenize('(10)')
      assert_equal(3, #tokens)
      assert_equal('(', tokens[1])
      assert_equal('10', tokens[2])
      assert_equal(')', tokens[3])
    end)

    test('(10 11) has four tokens: "(", "10" "11" and ")"', function()
      local tokens = tokenize('(10 11)')
      assert_equal(4, #tokens)
      assert_equal('(', tokens[1])
      assert_equal('10', tokens[2])
      assert_equal('11', tokens[3])
      assert_equal(')', tokens[4])
    end)
  end)

  context('read(s)', function()
    test('', function()
    -- TODO
    end)
  end)

  context('parse', function()
    test('', function()
    -- TODO
    end)
  end)

  context('to_string(exp)', function()
    test('', function()
    -- TODO
    end)
  end)end)

