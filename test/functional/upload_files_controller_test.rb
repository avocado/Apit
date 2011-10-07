require 'test_helper'

class UploadFilesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => UploadFile.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    UploadFile.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    UploadFile.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to upload_file_url(assigns(:upload_file))
  end

  def test_edit
    get :edit, :id => UploadFile.first
    assert_template 'edit'
  end

  def test_update_invalid
    UploadFile.any_instance.stubs(:valid?).returns(false)
    put :update, :id => UploadFile.first
    assert_template 'edit'
  end

  def test_update_valid
    UploadFile.any_instance.stubs(:valid?).returns(true)
    put :update, :id => UploadFile.first
    assert_redirected_to upload_file_url(assigns(:upload_file))
  end

  def test_destroy
    upload_file = UploadFile.first
    delete :destroy, :id => upload_file
    assert_redirected_to upload_files_url
    assert !UploadFile.exists?(upload_file.id)
  end
end
