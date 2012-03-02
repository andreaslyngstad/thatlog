require "minitest_helper"


describe Log do
  it "can be made" do
    log = Log.create!(event: "Hello World")
    log.event = "Hello World"
  end
end