PageExtension 50243 "Sales Return Order_PagEXT" extends "Sales Return Order"
{
    //GL2024 SourceTableView=WHERE(Document Type=FILTER(Return Orderr));
    layout
    {

    }
    actions
    {
        modify("Archive Document")
        {
            trigger OnBeforeAction()
            var
                ArchiveManagement: Codeunit ArchiveManagementEvent;
            begin

                ArchiveManagement.fSetQuoteToOrder(FALSE);
            end;
        }
    }
}