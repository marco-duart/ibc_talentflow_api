module AccessControl
  def user?(token)
    check_role('user', token)
  end

  def admin?(token)
    check_role('admin', token)
  end

  def ti?(token)
    check_role('ti', token)
  end

  private

  def check_role(*required_role, token)
    payload = TokenDecoder.decode_token(token)
    payload && (payload['role'] == required_role || payload['role'] == 'ti')
  end
end
