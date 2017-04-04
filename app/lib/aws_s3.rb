class AwsS3
  attr_reader :s3

  def initialize
    @s3 = Aws::S3::Client.new
  end
end