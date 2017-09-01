require 'net/http'
require 'uri'
require 'json'

URL = "http://testlodtask20172.azurewebsites.net/task"

#set the age = 1000 just in case of data error
youngest = {'male' => 1000, 'female' => 1000}

#getting already parsed from json object
def get_inf(url)
	uri = URI.parse(url)
	response = Net::HTTP.get_response(uri)
	JSON.parse(response.body)
end

def result(youngest)
	"The age of the youngest man: #{youngest['male']}\n" +
	"The age of the youngest woman: #{youngest['female']}"
end

list = get_inf(URL)

list.each do |man|
	url ="#{URL}/#{man['id']}"
	person = get_inf(url)
	sex = person['sex']
	age = person['age']
	youngest[sex] = age if youngest[sex] > age
end

puts result(youngest)
