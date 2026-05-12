xmlport 50001 "Imp Inv Ouv Ancien Article"
{
    schema
    {
        textelement(NodeName1)
        {
            tableelement(NodeName2; "Item Journal Line")
            {

            }
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    procedure GETTEMPLATE(TemplAteName: code[20]; BatchName: code[20])
    begin


    end;

    var
        myInt: Integer;
}