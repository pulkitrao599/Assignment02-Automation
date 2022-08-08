resource "azurerm_public_ip" "lbpubip" {
  name                = "publicIPLB"
  location            = var.location
  resource_group_name = var.rg
  allocation_method   = "Static"
  domain_name_label  = "assignment2-1308"
}


resource "azurerm_lb" "assignment2" {
  name                = "lb-assignment2-1308"
  location            = var.location
  resource_group_name = var.rg
  tags                  = local.common_tags
  frontend_ip_configuration {
    name                 = "PublicIPAddress-1308"
    public_ip_address_id = azurerm_public_ip.lbpubip.id
    
  }
}

resource "azurerm_lb_backend_address_pool" "be_ad_pool" {
  loadbalancer_id     = azurerm_lb.assignment2.id
  name                = "BackEndAddressPool-1308"
}

resource "azurerm_network_interface_backend_address_pool_association" "lb_pool_asso" {
  count                   = 2
  network_interface_id    = var.network_interface_id[count.index]
  ip_configuration_name   = "linux-centos-vm${format("%1d", count.index + 1)}-ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.be_ad_pool.id
}


resource "azurerm_lb_probe" "lb_prob" {
  loadbalancer_id     = azurerm_lb.assignment2.id
  name                = "tcpProbe"
  protocol            = "Http"
  request_path        = "/health"
  port                = 80
  interval_in_seconds = 5
  number_of_probes    = 2
}



resource "azurerm_lb_rule" "lb_rule" {
  loadbalancer_id                = azurerm_lb.assignment2.id
  name                           = "LBRule-1308"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress-1308"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.be_ad_pool.id]
}

