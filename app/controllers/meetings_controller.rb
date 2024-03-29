class MeetingsController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'

  def create_meeting
    end_time = Time.now + 1*60*60 # 1 hour in seconds

    uri = URI.parse("https://api.whereby.dev/v1/meetings")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request.body = JSON.dump({
      "endDate" => end_time.utc.strftime("%Y-%m-%dT%H:%M:%S.%LZ"),
      "fields" => "hostRoomUrl,viewerRoomUrl",
      "roomMode" => "group",
      "roomNamePrefix" => "Bookclub",
      "roomNamePattern" => "human-short",
    })
    request["Authorization"] = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmFwcGVhci5pbiIsImF1ZCI6Imh0dHBzOi8vYXBpLmFwcGVhci5pbi92MSIsImV4cCI6OTAwNzE5OTI1NDc0MDk5MSwiaWF0IjoxNzExMTk1NTY4LCJvcmdhbml6YXRpb25JZCI6MjIwMzUzLCJqdGkiOiI5OTI1YjNkNy0zYWEyLTRhNGMtYmNiNC1lZmFmY2YzYjkxYmIifQ.0VogW3uXqlhLFrfjr7cCDULK3BktOXdA-6oAJc4Exh0" # Replace YOUR_API_KEY with your actual API key

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    session_id = params[:sessionId]
    @session = Session.find(session_id)
    @session.update(host_url: JSON.parse(response.body)["hostRoomUrl"])
    @session.update(room_url: JSON.parse(response.body)["viewerRoomUrl"])

    render json: JSON.parse(response.body)


  end
end
