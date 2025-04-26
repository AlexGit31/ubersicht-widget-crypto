command: "curl -s 'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin,ethereum,solana,cardano,binancecoin,dogecoin,chainlink,litecoin,polkadot,uniswap&vs_currencies=usd&include_24hr_change=true'"

refreshFrequency: 60000

render: (output) ->
  try
    data = JSON.parse(output)
  catch error
    return "<div style='color: red;'>Erreur de chargement</div>"

  content = ""
  for id, info of data
    name = id.charAt(0).toUpperCase() + id.slice(1)
    price = if info.usd? then info.usd.toFixed(2) else "N/A"
    change = if info.usd_24h_change? then info.usd_24h_change.toFixed(2) else 0
    percent = "#{Math.abs(change)}%"

    arrow = if change >= 0
      "<span style='color: #00aa00; font-weight: bold;'>▲ #{percent}</span>"
    else
      "<span style='color: #cc0000; font-weight: bold;'>▼ #{percent}</span>"

    content += "<span style='margin-right: 32px;'>#{name}: $#{price} #{arrow}</span>"

  """
    <style>
      @keyframes scroll {
        0%   { transform: translateX(0%); }
        100% { transform: translateX(-50%); }
      }
    </style>
    <div style="width: 100vw; overflow: hidden; white-space: nowrap; font-family: sans-serif; font-size: 14px; color: black;">
      <div style="display: inline-block; white-space: nowrap; animation: scroll 60s linear infinite;">
        #{content} #{content}
      </div>
    </div>
  """

style: """
  top: 5px
  left: 0
  width: 100%
"""
