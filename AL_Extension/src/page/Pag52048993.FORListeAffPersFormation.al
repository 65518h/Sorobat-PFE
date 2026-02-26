page 52048993 "FOR-Liste Aff. Pers. Formation"
{
    //GL2024  ID dans Nav 2009 : "39001521"
    Caption = 'Liste Affec. Person.';
    PageType = List;
    SourceTable = Employee;
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("First And Last Name"; rec."First Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Selection demande"; rec."Selection demande")
                {
                    ApplicationArea = Basic;
                    Visible = "Selection demandeVisible";

                    trigger OnValidate()
                    begin
                        if not rec."Selection demande" then begin
                            // RecGPersonneDemandelFormation.Reset;
                            // if RecGPersonneDemandelFormation.Get(ProgramNo, Rec."No.") then
                            //     RecGPersonneDemandelFormation.Delete;
                        end;
                    end;
                }
                field(Selection; rec.Selection)
                {
                    ApplicationArea = Basic;
                    Caption = 'Sélection';
                    Visible = SelectionVisible;

                    trigger OnValidate()
                    begin
                        if not rec.Selection then begin
                            // RecGPersonnelFormation.Reset;
                            // if RecGPersonnelFormation.Get(ProgramNo, Rec."No.") then
                            //     RecGPersonnelFormation.Delete;
                        end;
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;

    var
        //   RecGPersonnelFormation: Record "Rappel Enregistre";
        ProgramNo: Integer;
        //  RecGPersonneDemandelFormation: Record "Client Carriere";
        [InDataSet]
        "Selection demandeVisible": Boolean;
        [InDataSet]
        SelectionVisible: Boolean;


    procedure GetProgramNo(ProgNo: Integer)
    begin
        ProgramNo := ProgNo;
    end;


    procedure VisibleFields(Demande: Integer)
    begin
        if Demande = 0 then begin
            "Selection demandeVisible" := false;
            SelectionVisible := true;
        end
        else begin
            "Selection demandeVisible" := true;
            SelectionVisible := false;
        end;
    end;
}

