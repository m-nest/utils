*** Settings ***
Resource    common.resource

*** Test Cases ***

RW001 Toggle CLI Access
    ${old}=    USP Query    Device.UserInterface.RemoteAccess.?
    Log    ${old}

RW002 Add Dummy Object
    ${out}=    USP Query    Device.LocalAgent.Subscription.+
    Log    ${out}
