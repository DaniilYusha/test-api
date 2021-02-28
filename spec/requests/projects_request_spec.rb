require 'rails_helper'

RSpec.describe "Api::V1::Projects", type: :request do
  include Docs::V1::Projects::Api

  describe 'GET #index' do
    include Docs::V1::Projects::Index

    context 'when success' do
      it 'returns success' do
        project = Project.create(name: 'Project #1')
        get api_v1_projects_path

        expect(response).to be_ok
      end
    end
  end
end
