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
  "Schema",
  { Action = "Schema" },
  function (msg)
    print("Get Schema")
    Send({
      Target = msg.From,
      Tags = { Type = "Schema" },
      Data = require('json').encode({
          Submisson = {
            Title = "Submit your Claim",
            Description = "Enter you details to make a claim to this quest!",
            Schema = nil
          }
      })
    })
  end
)

Handlers.add(
  'DefaultInteraction',
  { Action = "DefaultInteraction" },
  function(msg)
    print('DefaultInteraction')

    Send({
      Target = CHAT_TARGET,
      Tags = {
        Action = 'ChatMessage',
        ['Author-Name'] = 'Submission Llama',
      },
      Data =
      "Hello, I will take your submissions very soon! 😃",
    })

  end
)
