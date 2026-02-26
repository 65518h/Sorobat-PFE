TableExtension 50165 PurchasingEXT extends Purchasing
{
    fields
    {
        field(50001; "Purchase Order"; Boolean)
        {
            Caption = 'Commande Achat';
            Description = 'HJ DSFT 27-04-2012';
        }
        field(8003945; "Copy Extended Text"; Boolean)
        {
            Caption = 'Copy Attached Text';
        }
    }
    trigger OnInsert()
    begin
        //ACHAt_DIRECT
        "Copy Extended Text" := TRUE;
        //ACHAt_DIRECT//
    end;


}

