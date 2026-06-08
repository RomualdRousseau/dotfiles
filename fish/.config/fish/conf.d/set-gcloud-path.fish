if test -d "/opt/google-cloud-sdk/bin"
  if not contains "/opt/google-cloud-sdk/bin" $PATH
    set -x PATH "/opt/google-cloud-sdk/bin" $PATH
  end
end
