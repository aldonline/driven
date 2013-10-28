_ = require 'underscore'

module.exports = ( {title, docs, head_html} ) ->

    docs_html = _.map( docs, ((d) -> d.line_html()) ).join(' ')

    s = """
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta http-equiv="Content-Type" content="Type=text/html; charset=utf-8"/>

      <title>#{title}</title>

      <script src="/js/jquery-1.9.1.min.js"></script>

      <script src="/bootstrap/js/bootstrap.min.js"></script>
      <link rel="stylesheet" href="/bootstrap/css/bootstrap.min.css"/>

      #{head_html}

    </head>
      <div class="article-container">
        #{docs_html}
      </div>
    </html>
    """