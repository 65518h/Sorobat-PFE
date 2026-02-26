Page 59998 "Droit Formulaire"
{
    PageType = List;
    //GL2024 License  SourceTable = "Object";
    //GL2024 License
    SourceTable = AllObj;
    //GL2024 License
    /* //GL2024 License  SourceTableView = sorting("Object Type", "Company Name", ID)
                         where(Type = const(Page));*///GL2024 License
    SourceTableView = sorting("Object Type", "Object name", "Object id")
                      where("Object Type" = const(Page));
    ApplicationArea = all;
    Caption = 'Droit Formulaire';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                ShowCaption = false;
                field(ID; REC."Object id")
                {
                    ApplicationArea = all;
                }
                field(Caption; rec."Object Name")
                {
                    ApplicationArea = all;
                }
                /*  //GL2024 License  field(Date; REC.Date)
                    {
                        ApplicationArea = all;
                    }
                    field(Time; REC.Time)
                    {
                        ApplicationArea = all;
                    }
                    field("Version List"; REC."Version List")
                    {
                        ApplicationArea = all;
                    }*///GL2024 License
                field(Affectation; Affectation)
                {
                    ApplicationArea = all;
                    Caption = 'Affectation';

                    trigger OnAssistEdit()
                    begin
                        RecAutorisationEtape.SetRange("Type Reglement", 'PAGE');
                        RecAutorisationEtape.SetRange(Etape, REC."Object id");
                        PAGE.RunModal(Page::"Autorisation Etapes", RecAutorisationEtape);
                    end;
                }
            }
        }
    }

    actions
    {
    }

    var
        Affectation: Code[20];
        RecAutorisationEtape: Record "Autorisation Etapes2";
}

