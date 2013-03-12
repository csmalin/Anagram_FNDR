get '/' do
  if params[:word]
    # If we see a URL like /?word=apples redirect to /apples
    #
    # The HTTP status code 301 means "moved permanently"
    # See: http://www.sinatrarb.com/intro#Browser%20Redirect
    #      http://en.wikipedia.org/wiki/HTTP_301
    redirect to("/#{params[:word]}"), 301
  else
    # Look in app/views/index.erb
    erb :index
  end
end

get '/:word' do
  word = params[:word]
  "Show a list of anagrams for \"#{word}\""
  words = Word.where('sorted = ?', word.strip.downcase.chars.sort.join)
  words = words.to_a.map { |word| word.name }.uniq
  # erb :anagrams, :locals => { :words => words }
  content_type :json
  {words: words}.to_json
end

# Sinatra's get, post, put, etc. URL helpers match against the shape/form of a URL.
# That is,
#
#   get '/:word' do
#     ...
#   end
#
# means "call this block any time we see a URL that looks like /<word>"
#
# The parts of a URL are separated by a /, so these match '/:word'
#
#   /foo, /bar, /apple+pie, /four+score+and+seven+years+ago
#
# whereas these do not match '/:word'
#
#   /, /word1/word2, /this/is/a/long/url, /articles/123
#
# This will bind whatever fits in the :word spot in the URL
# to params[:word], "as if" it were passed in via a query string
# like ?word=apples
