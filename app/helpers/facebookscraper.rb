require 'net/http'
require 'json'
require 'QuestionExtractor'
require 'QuestionMailer'
module Facebookscraper
    
    
    def self.run opts={}
        datamap = getDataFromFacebook(opts)
        datamap.length > 1 ? processData(datamap) : return
    end
    
    def self.getDataFromFacebook opts
        data = Net::HTTP.get(geturl(opts))
        JSON.parse(data)
    end
    
    def self.geturl opts
        #move this to configuration
        token = Rails.application.secrets.facebookkey
        URI(opts[:url] || "https://graph.facebook.com/v2.5/141573075895262/feed?fields=comments,full_picture,message,name,caption,description,link,from,type,object_id&access_token=#{token}")
    end
    
    def self.processData(datamap)
        datatosave = queryIfExists(datamap['data'])
        datatosave.length > 1 ? bulkSave(datatosave) && run({url: datamap['paging']['next']}) : sendReport()
    end
    
    def self.queryIfExists jsonrecords
        fbidsinjson = jsonrecords.map{|record| record['id'] }
        duplicateRecordFbId = Question.where({fbid:fbidsinjson}).pluck(:fbid)
        jsonrecords.select{|record| !duplicateRecordFbId.include? record['id'] }
    end
    
    def self.bulkSave data
        questions = data.map{|record| QuestionExtractor.geneareteQuestion(record) }.compact
        Question.create(questions)
    end
    
    def self.sendReport
        addedCount = Question.where('created_at >= ?', 1.day.ago).count
        QuestionMailer.report(Rails.application.secrets.adminemail,addedCount).deliver
    end
end
