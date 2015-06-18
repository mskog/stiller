require 'spec_helper'

describe Stiller::API do
  include Rack::Test::Methods

  def app
    Stiller::API
  end

  describe "Create" do

    When{get "/still", params}

    context "with valid parameters", :focus do
      Given(:file){File.open('spec/fixtures/gizmo.webm')}
      Given{stub_request(:get, url).to_return(body: file.read)}

      Given(:url){'http://www.example.com/foobar.webm'}
      Given(:params){{url: url}}

      Then{expect(last_response.status).to eq 200}
      And{expect(last_response.length/1000).to eq 130}
      And{expect(last_response.content_type).to eq 'image/png'}
    end

    context "with missing parameters" do
      Given(:params){{}}
      Given(:parsed_response){JSON.parse(last_response.body)}
      Given(:expected_response){{"error" => "url is missing"}}
      Then{expect(last_response.status).to eq 400}
      And{expect(parsed_response).to eq expected_response}
    end

    context "with invalid url" do
      Given(:params){{url: 'hello'}}
      Given(:parsed_response){JSON.parse(last_response.body)}
      Given(:expected_response){{"error" => "url is invalid"}}
      Then{expect(last_response.status).to eq 400}
      And{expect(parsed_response).to eq expected_response}
    end
  end
end
