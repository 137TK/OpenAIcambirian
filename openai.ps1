# まず ChatGPT を使うための各種パラメータを指定します。

$apiKey = 'Your API Key'

$endpoint = "https://api.openai.com/v1/chat/completions"

$question = 'How can I write Hello, world program with Rust?'

$body = @{
    model = "gpt-3.5-turbo"  # モデルを指定
    messages = @(
        @{
            role = 'user'
            content = $question
        }
    )
    max_tokens = 50  # 応答の最大トークン数（応じて調整可能）
    stop = @("\n", "Translate:")  # 応答を終了するトークン
} | ConvertTo-Json -Depth 3

Write-Output $body

# 最後に ChatGPT に質問を投げます
# APIリクエストの送信
$response = Invoke-WebRequest `
  -Method Post `
  -Uri $endpoint `
  -ContentType 'application/json' `
  -Headers @{"Authorization" = "Bearer $apiKey"} `
  -Body $body

# 返ってきた回答を表示します
$Answer = ($response.Content | ConvertFrom-Json).choices[0].message.content
Write-Output $Answer