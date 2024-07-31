local sqlite3 = require('lsqlite3')
Db = sqlite3.open_memory()
dbAdmin = require('@rakis/DbAdmin').new(Db)
--[[
RealityEntitiesStatic['-8YLJnxnKmfhqWYIuHz-8TdJVfRd3pFgTkQPhykpjBg'] = {
  Position = { 10, 10 },
  Type = 'Avatar',
  Metadata = {
    DisplayName = 'Submission Llama',
    SkinNumber = 7,
    Interaction = {
       Type = 'SchemaForm',
       Id = "Submission"
     },
   }
]]

SUBMISSIONS_SCHEMA = [[
CREATE TABLE IF NOT EXISTS Submissions (
  ID INTEGER PRIMARY KEY AUTOINCREMENT,
  Name TEXT NOT NULL,
  Sandbox TEXT NOT NULL,
  Email TEXT NOT NULL UNIQUE,
  Repo TEXT NOT NULL,
  Quest TEXT NOT NULL
);
]]

function Init()
  Db:exec(SUBMISSIONS_SCHEMA)
  return "db initialized."
end

local function insertSubmission(name, sandbox, email, repo, quest)  
  local stmt = Db:prepare[[
      INSERT INTO Submissions (Name, Sandbox, Email, Repo, Quest)
      VALUES (?, ?, ?, ?, ?)
  ]]

  stmt:bind_values(name, sandbox, email, repo, quest)

  local result = stmt:step()
  if result ~= sqlite3.DONE then
      print("Error inserting data: " .. Db:errmsg())
  else
      print("Record inserted successfully")
  end

  stmt:finalize()
end

Handlers.add(
  "Submit",
  { Action = "SubmitClaim" },
  function (msg)
    insertSubmission(msg.Name, msg.Sandbox, msg.Email, msg.Repo, msg.Quest)
    Agent.speak("Thank you " .. msg.Name .. " for your submission to the " .. msg.Quest)
  end
)

Handlers.add(
  "Schema",
  { Action = "Schema" },
  function (msg)
    print("Get Schema")
    Agent.speak('Please fill out this form to submit your entry!')
    Send({
      Target = msg.From,
      Tags = { Type = "Schema" },
      Data = require('json').encode({
          Submission = {
            Title = "Submit your Claim",
            Description = "Enter you details to make a claim to this quest!",
            Schema = {
              Tags = {
                ["type"] = "object",
                ["required"] = { "Action" },
                ["properties"] = {
                  ["Action"] = {
                    ["type"] = "string",
                    ["const"] = "SubmitClaim"
                  },
                  ["Quest"] = {
                    ["type"] = "string",
                    ["title"] = "Quest",
                    ["enum"] = {"Coin", "AI/NPC", "Reality"}
                  },
                  ["Sandbox"] = {
                    ["type"] = "string",
                    ["title"] = "Reality Viewer Id",
                    ["minLength"] = 43,
                    ["maxLength"] = 43
                  },
                  ["Repo"] = {
                    ["type"] = "string",
                    ["title"] = "Source Code URL",
                    ["minLength"] = 2,
                    ["maxLength"] = 100
                  },
                  ["Email"] = {
                    ["type"] = "string",
                    ["title"] = "Email Address",
                    ["minLength"] = 10,
                    ["maxLength"] = 100
                  },
                  ["Name"] = {
                    ["type"] = "string",
                    ["title"] = "Your Name",
                    ["minLength"] = 2,
                    ["maxLength"] = 50
                  }
                }
              }
            }
          }
      })
    })
  end
)
