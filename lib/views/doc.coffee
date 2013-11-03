module.exports = ( {doc, head_html} ) ->

    img = ''
    if doc.image()?
      img = """<img class="article-image" src="#{doc.image()}"/>"""


    s = """
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta http-equiv="Content-Type" content="Type=text/html; charset=utf-8"/>

      <title>#{doc.title()}</title>

      #{doc.meta_tags()}

      <script src="/js/jquery-1.9.1.min.js"></script>

      <script src="/bootstrap/js/bootstrap.min.js"></script>
      <link rel="stylesheet" href="/bootstrap/css/bootstrap.min.css"/>
      
      <style>#{doc.styles()}</style>

      <link rel="stylesheet" href="/highlight.js/styles/default.css"/>
      <script src="/highlight.js/highlight.pack.js"></script>
      <script>hljs.initHighlightingOnLoad();</script>

      #{head_html}

    </head>
      <body>
        <!--
        <div class="navbar navbar-fixed-top">
          <div class="navbar-inner">
            <a class="brand" href="#">Title</a>
            <ul class="nav">
              <li class="active"><a href="/">Home</a></li>
              <li><a href="#">Link</a></li>
              <li><a href="#">Link</a></li>
            </ul>
          </div>
        </div>
        -->

        <div class="article-container">

          #{img}

          <p class="article-title">#{doc.title()}</p>
          <p class="article-subtitle">#{doc.subtitle()}</p>

          <p class="article-detail">
            <span>Created: #{doc.created()}</span>
            |
            <span>Modified: #{doc.modified()}</span>
            | 
            <a href="#{doc.pdf_link()}">Download as PDF</a>
            |
            <a href="https://docs.google.com/document/d/#{doc.id()}/edit">Edit</a>
          </p>
          <div class="article-tags">#{doc.tags_html()}</div>
          <div class="article-body">
            #{doc.body()}
          </div>

        </div>

      </body>
    </html>
    """