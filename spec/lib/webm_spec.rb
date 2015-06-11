require 'spec_helper'
require 'digest'
require_relative '../../lib/webm'

describe Stiller::Webm do
  context "from url" do
    Given(:file){File.open('spec/fixtures/gizmo.webm')}
    Given(:url){'http://www.example.com/foobar.webm'}
    Given{stub_request(:get, url).to_return(body: file.read)}
    subject{described_class.from_url(url)}

    describe "#still", :focus do
      When(:result){subject.still}
      Then{expect(result.size/1000).to eq 130}
    end
  end

  context "from file" do
    Given(:file){File.open('spec/fixtures/gizmo.webm')}
    subject{described_class.new(file)}

    describe "#still" do
      When(:result){subject.still}
      Then{expect(result.size/1000).to eq 130}
    end
  end
end
