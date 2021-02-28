RSpec.describe "Api::V1::Projects", type: :request do
  include Docs::V1::Projects::Api

  describe 'GET #index' do
    include Docs::V1::Projects::Index

    context 'when success' do
      it 'returns success', :dox do
        project = Project.create(name: 'Project #1')
        get api_v1_projects_path

        expect(response).to be_ok
      end
    end
  end

  describe 'POST #create' do
    include Docs::V1::Projects::Create

    let(:params) { { name: 'Amazing Day Planning!' } }

    before { post api_v1_projects_path, params: params, as: :json }

    it 'creates a project', :dox do
      expect(response).to be_created
    end
  end
end
