require 'rails_helper'

module Integral
  RSpec.describe ApplicationHelper, type: :helper do

    describe '#anchor_to' do
      let(:body) { 'testbody' }
      let(:location) { 'testanchor' }
      let(:expected_path) { '/#testanchor' }

      it 'generates a link_to tag with current page and supplied anchor' do
        allow(helper).to receive(:url_for).and_return('/')
        expect(helper).to receive(:link_to).with(body, expected_path).and_return('test/url')

        expect(helper.anchor_to(body, location)).to eq 'test/url'
      end
    end

    describe '#render_flashes' do
      let(:flash) { { notice: 'Foo notice message',
        alert: 'Foo alert message',
        error: 'Foo error message'
      } }
      let(:expected_markup) { "<div id=\"flash_list\">#{notice_markup}#{alert_markup}#{error_markup}</div>" }
      let(:notice_markup) { "<div class=\"flash\" data-message=\"Foo notice message\" data-klass=\"notice\"></div>" }
      let(:alert_markup) { "<div class=\"flash\" data-message=\"Foo alert message\" data-klass=\"alert\"></div>" }
      let(:error_markup) { "<div class=\"flash\" data-message=\"Foo error message\" data-klass=\"error\"></div>" }

      before { allow(helper).to receive(:flash).and_return(flash) }

      it 'renders out the correct markup' do
        expect(helper.render_flashes).to eq(expected_markup)
      end
    end

    describe '#icon_link_to' do
      let(:url) { 'some/url' }
      let(:icon_path) { 'some_icon_path' }
      let(:html_options) { {foo: :bar} }

      it 'renders an icon link' do
        expect(helper).to receive(:link_to).with("<i class='material-icons left'>#{icon_path}</i>", url, html_options)

        helper.icon_link_to(icon_path, url, html_options)
      end
    end
  end
end
