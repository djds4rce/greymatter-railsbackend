require 'parse-ruby-client'
require 'open-uri'
module QuestionExtractor 
    
    def self.geneareteQuestion question_json 
        question_obj = {}
        question_obj[:fbid] = question_json['id']
        question_obj[:from] = question_json['from']['name']
        question_obj[:description] = question_json['message']
        question_json['comments'] ? question_obj[:comments] = question_json['comments'].to_s : ''
        if(question_json['full_picture'])
            client = Parse.create application_id: 'QEh1MqdvfYjOLCB3GScSlxp6FXAxC3SLI8uimu8J',api_key: 'k12HV0PDOhT3rUycNgnGLmmupijWb8l29XhjC6s8'
            imagedata = open(question_json['full_picture'])
            image = client.file({local_filename:"#{question_json["id"]}.jpg",body:imagedata.read,:content_type => "image/jpeg"})
            image.save
            question_obj[:picture] = image.url
        end
        (question_obj[:description] || question_obj[:picture] || question_obj[:comments]) ? question_obj : false
    end
end 