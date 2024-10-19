# Distribution Group
Distribution groups are used for sending notifications to a group of people. They can receive external email if enabled by the administrator.
Distribution groups are best for situations where you need to broadcast information to a set group of people, such as "People in Building A" or "Everyone at Contoso.". Learn more about distribution group [Microsoft's documentation](https://learn.microsoft.com/en-us/microsoft-365/admin/create-groups/compare-groups?view=o365-worldwide#distribution-groups).

## About the script
The [add-members-to-distroList script](add-members-to-distroList.ps1) will help engineers and administrators add multiple users to a distribution group. 

### Script breakdown
1. It will import the [ExchangeOnlineManagement module](https://learn.microsoft.com/en-us/powershell/exchange/exchange-online-powershell-v2?view=exchange-ps)
2. Use the [Connect-ExchangeOnline](https://learn.microsoft.com/en-us/powershell/module/exchange/connect-exchangeonline?view=exchange-ps) method to connect to your EAC
3. It will loop through a CSV file that contains the email addresses of the members and then use the [Add-DistributionGroupMember ](https://learn.microsoft.com/en-us/powershell/module/exchange/add-distributiongroupmember?view=exchange-ps) cmdlet to add the members to the group.
