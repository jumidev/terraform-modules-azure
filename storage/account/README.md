# Storage account

Module to create an empty Azure storage account.

By default it will enable soft delete by using az cli command as it is not possible with the azurerm resource yet. To disable soft delete set `soft_delete_retention` to `null`. Otherwise set it to the number of retention days, default is 31.

