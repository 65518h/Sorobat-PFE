page 50324 "Refused Reason"
{
    PageType = Document;
    Caption = '"Refused Reason';

    layout
    {
        area(Content)
        {
            group("Refused Reason")
            {
                Caption = 'Refused Reason';
                field(Reason; Reason)
                {
                    Caption = 'reason';
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }
    procedure GetReason() Return: Text
    begin
        exit(Reason);
    end;

    var
        Reason: Text;
}