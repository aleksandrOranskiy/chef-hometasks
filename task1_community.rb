#
# Cookbook:: task1_community
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

ssh_authorize_key 'student@EPBYMINW2695.minsk.epam.com' do
  key 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDYUnB9N7TLSWCQ8/8FLsncXo+29/o7O9udbPsJ09xLYzrhiyIbOUbFZTysVyvMBU4NB4JQDvRzt04IZB0Prr6OmSbXkSnfbrnD9lMzg6+mKcT1L2JXvGNpI32MCvsQDbZU/53EjMh3wLpACrP6tD+13NRwqUU/SY4Fa9pZaISm8z5/kAnGsi38xWxQP22EDxEwF+5iy6c0zIMI1FhpCYMR084GmUMVinwH0ABHGPLkYD+M4CZE/ACdW7hHJf44raSBrkncN2qG3y6K8vRqcv/zXCjb9IGD/UmC32wNKtT45NDEv8IG1pmPsks31K7YjSgw25Tt+/G8BRM3nf5iIAa3'
  user 'root'
end
