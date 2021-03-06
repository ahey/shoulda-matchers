require 'spec_helper'

describe Shoulda::Matchers::ActionController::RedirectToMatcher do
  context 'a controller that redirects' do
    it 'accepts redirecting to that url' do
      controller_redirecting_to('/some/url').should redirect_to('/some/url')
    end

    it 'rejects redirecting to a different url' do
      controller_redirecting_to('/some/url').
        should_not redirect_to('/some/other/url')
    end

    it 'accepts redirecting to that url in a block' do
      controller_redirecting_to('/some/url').
        should redirect_to('somewhere') { '/some/url' }
    end

    it 'rejects redirecting to a different url in a block' do
      controller_redirecting_to('/some/url').
        should_not redirect_to('somewhere else') { '/some/other/url' }
    end

    def controller_redirecting_to(url)
      build_response { redirect_to url }
    end
  end

  context 'a controller that does not redirect' do
    it 'rejects redirecting to a url' do
      controller = build_response { render :text => 'hello' }

      controller.should_not redirect_to('/some/url')
    end
  end

  it 'provides the correct description when provided a block' do
    matcher = redirect_to('somewhere else') { '/some/other/url' }

    matcher.description.should == 'redirect to somewhere else'
  end
end
