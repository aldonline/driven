

# http://www.iacquire.com/blog/18-meta-tags-every-webpage-should-have-in-2013/

module.exports = meta_tags = ( {description, title, image, url, facebook_id, google_plus_id} ) ->
  tags = []
  mktag = ( name ) -> (o) ->
    parts = [name]
    parts.push k + '="' + v + '"' for k, v of o
    tags.push '<' + parts.join(' ') + '/>'

  meta = mktag 'meta'
  link = mktag 'link'

  # 155 chars
  meta name: 'description', content: description

  # Rel-Author– This is a meta tag that can be implemented that specifies who the author
  # of a piece of content is and uses Google+ to identify them.
  # Initially Google rolled this out as just a tag that you place in the <head> of the code,
  # but ultimately they would realize it’s not realistic that authors will have that type of
  # control over the page and expanded to a more modular form.Format:
  # For the version that goes in the <head> tag, you use the following:
  link rel: 'author', href:'https://plus.google.com/' + google_plus_id


  ###################################################
  # FACEBOOK
  ###################################################

  # og:title –This is the title of the piece of content.
  # You should use this as a headline that will appeal to the Facebook audience.
  # It is completely ok to use a different title than the one on the actual site
  # as long as the message is ultimately the same. You have 95 characters to work with.Format:
  meta property: 'og:title', content: title
  
  # og:type – This is the type of object your piece of content is.
  # For your purposes it will usually be blog, website or article,
  # but if you want to get fancy Facebook provides a complete list.Format:
  meta property: 'og:type', content: 'article'

  # og:image -This is the image that Facebook will show in the screenshot of the content.
  # Be sure to specify a square image to ensure the best visibility in a user’s timeline.
  # If you don’t specify an image at all you are left to the mercy of the user to pick
  # which image represents your content based on what Facebook can scrape.
  # That is typically not the way to ensure the best first impression.Format:
  meta property: 'og:image', content: image

  # og:url– This is simply the URL of the page (or edge).
  # You should specify this especially if you have duplicate content issues to make sure
  # the value of the edge in Facebook is consolidated into one URL.Format:
  meta property:'og:url', content: url

  # og:description -This is the description Facebook will show in the screenshot of the piece of content.
  # Just like the standard meta description it should be catchy and contain a call to action,
  # but in this case you have nearly twice the number of characters to work with.
  # Make sure this too speaks to the Facebook audience.
  # You have to 297 characters to make it happen.Format:
  meta property: 'og:description', content: description

  # fb:admins – This metatag is critical for getting access to the wealth of data made available
  # via Facebook Insights. You simply have to specify the Facebook User IDs
  # in the metadata of those users you want to have access.
  # For more information on Facebook Insights see the documentation.Format:
  meta property: 'fb:admins',  content: facebook_id

  ###################################################
  # TWITTER
  ###################################################

  # twitter:card– This is the card type. Your options are summary, photo or player.
  # Twitter will default to “summary” if it is not specified.Format:
  meta name: 'twitter:card', content: 'summary'

  # twitter:url- This is the URL of the content.Format:
  meta name: 'twitter:url', content: url

  # twitter:title–This is the title of the content to be shared and should be limited to 70
  # characters after which Twitter will truncate.
  # Again, go for headlines instead of keywords.Format:
  meta name: 'twitter:title', content: title
  
  # twitter:description– This is the description of the content to be shared
  # and should be limited to 200 characters after which Twitter will truncate.
  # Again, go for engaging text, you have more opportunity here than the actual tweet does.Format:
  meta name: 'twitter:description', content: description

  # twitter:image – This is the image that will be displayed on the Twitter Card
  # and it should be a square image no smaller than 60×60 pixels.
  meta name: 'twitter:image', content: image

  # TODO: Google+ Schema.org

  # etc...

  tags



test = ->
  t = meta_tags
    title: 'Title'
    description: 'Description'
    url: 'http://foo.com/bar'
    image: 'http://foo.com/image.png'
    facebook_id: '545415493'
    google_plus_id: '102127397366064106648'
  console.log t


