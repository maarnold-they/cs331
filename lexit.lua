local lexit = {}

lexit.KEY = 1
lexit.ID = 2
lexit.NUMLIT = 3
lexit.STRLIT = 4
lexit.OP = 5
lexit.PUNCT = 6
lexit.MAL = 7

lexit.catnames = {
  "Keyword",
  "Identifier",
  "NumericLiteral",
  "StringLiteral",
  "Operator",
  "Punctuation",
  "Malformed"
}

-- Character identification functions

local function isLetter(c)
  if c:len() == 1 and ((c >= "A" and c <= "Z") or (c >= "a" and c <= "z")) then
    return true
  end
  return false
end

local function isDigit(c)
  if c:len() == 1 and (c >= "0" and c <= "9") then
    return true
  end
  return false
end

local function isWhitespace(c)
  if c:len() == 1 and (c == " " or c == "\t" or c == "\v" or c == "\n" or c == "\r" or c == "\f") then
    return true
  end
  return false
end

local function isPrintableASCII(c)
  if c:len() == 1 and (c >= " " or c <= "~") then
    return true
  end
  return false
end

local function isIllegal(c)
  if c:len() ~= 1 or isWhitespace(c) or isPrintableASCII(c) then
    return false
  end
  return true
end

-- Lexer

function lexit.lex(program)
  -- data members
  
  local pos
  local state
  local ch
  local lexstr
  local category
  local handlers
  
  -- States
  
  local DONE = 0
  local START = 1
  local LETTER = 2
  local DIGIT = 3
  local EXPONENT = 4
  local QUOTE = 5
  local EQUAL = 6
  local BANG = 7
  local LESSTHAN = 8
  local GREATERTHAN = 9
  local PLUS = 10
  local MINUS = 11
  local STAR = 12
  local FSLASH = 13
  local MODULO = 14
  local RBRACKET = 15
  local LBRACKET = 16
  
  local function currChar()
    return program:sub(pos,pos)
  end
  
  local function nextChar()
    return program:sub(pos+1,pos+1)
  end
  
  local function add1()
    lexstr = lexstr .. currChar()
  end
  
  local function drop1()
    pos = pos + 1
  end
  
  
  local function skipToNextLexeme()
  end
  
  --State handlers
  local function handle_DONE()
    error("'DONE' state should not be handled\n")
  end
  
  local function handle_START()
    add1()
    state = DONE
    category = lexit.PUNCT
  end
  
  local function handle_LETTER()
  end
  
  local function handle_DIGIT()
  end
  
  
  
  handlers = {
    [DONE] = handle_DONE,
    [START] = handle_START,
    }
  
  local function getLexeme(dummy1, dummy2)
    if pos > program:len() then
      return nil, nil
    end
    lexstr = ""
    state = START
    while state ~= DONE do
      ch = currChar()
      handlers[state]()
    end
    
    skipToNextLexeme()
    return lexstr, category
  end
  
  pos = 1
  skipToNextLexeme()
  return getLexeme, nil, nil
  
end

return lexit