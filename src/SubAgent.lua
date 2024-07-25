-- Name: Submission Llama

CHAT_TARGET = CHAT_TARGET or 'pdh8jUoBcMXeG6WxPitL7vWMqQAaGbLI-UDWe76uGHc'

-- To add this agent to your verse, configure your Static Entities table, e.g.:
-- VerseEntitiesStatic = {
--   ['<your agent process Id>'] = {
--     Position = { 10, 10 },
--     Type = 'Avatar',
--     Metadata = {
--       DisplayName = 'Submission Llama',
--       SkinNumber = 3,
--       Interaction = {
--         Type = 'Default',
--       },
--     },
--   },
-- }
Handlers.add(
  "Submit",
  { Action = "SubmitClaim" },
  function (msg)
    print(msg.Data)
    print(msg.Tags)
  end
)

Handlers.add(
  "Schema",
  { Action = "Schema" },
  function (msg)
    print("Get Schema")
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
                    ["title"] = "Demo Sandbox",
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
                  }
                }
              }
            }
          }
      })
    })
  end
)

