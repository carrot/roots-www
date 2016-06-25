$        = require('zepto-browserify').$
hljs     = require 'highlight.js'
Parallax = require 'parallax.js'
Chart    = require 'chart.js'
moment   = require 'moment'
find     = require 'lodash.find'

# code highlighting

hljs.initHighlightingOnLoad()

# plax

opts = { scalarX: 2, scalarY: 20 }

if $('#index').length
  new Parallax($('#header .trees')[0], opts)
  new Parallax($('#intro .trees')[0], opts)
  new Parallax($('#resources .trees')[0], opts)
else if $('.trees').length
  new Parallax($('nav .trees')[0], opts)
  new Parallax($('main .trees')[0], opts)

# video switcher

titlebar = $('.video .stage h2')
iframe = $('.video .stage iframe')
thumbs = $('.more-videos .others li')

thumbs.on 'click', ->
  new_title = $(@).find('span').text()
  new_id = $(@).data('id')

  titlebar.text(new_title)
  iframe.attr('src', "https://youtube.com/embed/#{new_id}?hd=1&rel=0&autohide=1&showinfo=0&autoplay=1")

  thumbs.removeClass('active')
  $(@).addClass('active')

# analytics

colors = [[198, 206, 158], [237, 222, 171], [227, 184, 145], [217, 67, 98], [94, 67, 83], [84, 89, 126], [131, 186, 228], [83, 104, 135], [198, 206, 158], [237, 222, 171], [227, 184, 145]]

query_keen = (type, opts, cb) ->
  query = new Keen.Query(type, opts)
  client.run(query, cb)

if $('body#analytics').length
  client = new Keen
    projectId: '5252fe3d36bf5a4f54000008'
    readKey: 'c26d1b67ebe0f6b8f13441477cf324d84138abe6f79c4127bd2f318e57c94cc228cc102703d00b58cda6277e10d4b6aee1081def2701649dee56938774a5c4241450d382051c729b086370a4cba2dd9712a85814249864bd19942e523cac2116e5dc4c5f3f4276469da0180506b5bb5d'

  query_keen 'count',
    eventCollection: 'api'
    groupBy: 'name'
    timeframe: 'this_7_days'
    interval: 'daily'
  , (data) ->
    chart_data = format_data(data)
    ctx = $('#api_usage')[0].getContext('2d')
    chart = new Chart(ctx).Line(chart_data, multiTooltipTemplate: "<%if (datasetLabel){%><%=datasetLabel%>: <%}%><%= value %>")

  query_keen 'count',
    eventCollection: 'commands'
    groupBy: 'name'
    timeframe: 'this_7_days'
    interval: 'daily'
  , (data) ->
    chart_data = format_data(data)
    ctx = $('#cli_usage')[0].getContext('2d')
    chart = new Chart(ctx).Line(chart_data, multiTooltipTemplate: "<%if (datasetLabel){%><%=datasetLabel%>: <%}%><%= value %>")

format_data = (data) ->
  res = { labels: [], datasets: [] }

  for item in data.result
    res.labels.push(moment(item.timeframe.start).format('M/D/YYYY'))
    for val, i in item.value
      category = find(res.datasets, label: val.name)
      if not category
        info = generate_colorset(colors[i])
        info.label = val.name
        info.data = [val.result]
        res.datasets.push(info)
      else
        category.data.push(val.result)

  return res

generate_colorset = (arr) ->
  fillColor: "rgba(#{arr.join(',')},0.2)"
  strokeColor: "rgba(#{arr.join(',')},1)"
  pointColor: "rgba(#{arr.join(',')},1)"
  pointStrokeColor: "#fff"
  pointHighlightFill: "#fff"
  pointHighlightStroke: "rgba(#{arr.join(',')},1)"
