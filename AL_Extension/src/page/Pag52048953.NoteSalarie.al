page 52048953 "Note Salariée"
{//GL2024  ID dans Nav 2009 : "39001474"
    DeleteAllowed = true;
    InsertAllowed = true;
    PageType = Card;
    SaveValues = true;
    SourceTable = Employee;
    SourceTableView = sorting("No.")
                      order(ascending)
                      where(Status = filter(Active));
    ApplicationArea = all;
    UsageCategory = Administration;
    Caption = 'Note Salariée';
    layout
    {
        area(content)
        {

            group(General)
            {
                ShowCaption = false;


                field(year; year)
                {
                    ApplicationArea = Basic;
                    Caption = 'Année :';

                    trigger OnValidate()
                    begin
                        yearOnAfterValidate;
                    end;
                }
                field(TrimestreT; TrimestreT)
                {
                    ApplicationArea = Basic;
                    Caption = 'Trimestre  :';
                    Editable = false;
                }
                field("Employee No. Filter"; Rec."Employee No. Filter")
                {
                    ApplicationArea = Basic;
                    Caption = '<Filtre Employé>';
                    Visible = false;
                }
            }

            repeater(Control1102752009)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    NotBlank = true;
                }
                field("First Name"; rec."First Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Last Name"; rec."Last Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }

                field(Note; rec.Note)
                {
                    ApplicationArea = Basic;
                }
                field(Pourcentage; Rec.Pourcentage) { ApplicationArea = all; }


            }
        }
    }

    actions
    {
        area(Promoted)
        {
            group(Validation1)
            {
                Caption = 'Validation';

                actionref(Valider1; Valider) { }

            }
        }
        area(navigation)
        {
            group(Validation)
            {
                Caption = 'Validation';
                action(Valider)
                {
                    ApplicationArea = Basic;
                    Caption = 'Valider';
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    begin
                        if year = 0 then
                            Error('Année doit être mentionnée!!!');

                        T1.Reset;
                        T1.CopyFilters(Rec);
                        valid.ValiderNote(T1, year, TrimestreT);
                    end;
                }
            }
        }
    }

    trigger OnInit()
    begin
        if TrimestreT <> 4 then
            TrimestreT := 4;
        //MESSAGE(FORMAT(TrimestreT));
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Error(TEXT01)
    end;

    var
        TrimestreT: Option "1ère","2ème","3ème","4ème",Annuel;
        year: Integer;
        Val: array[5] of Decimal;
        i: Integer;
        Tot: Decimal;
        ValT: array[5] of Decimal;
        LigneNote: Record "Ligne Pointage Salarié Chanti";
        LigneNoteTmp: Record "Ligne Pointage Salarié Chanti";
        Nline: Integer;
        valid: Codeunit "Note Personnel";
        T1: Record Employee;
        Mnt: Decimal;
        "Filtre Catégorie": Option " ","Hors Grille",Grille;
        TEXT01: label 'Vous avez atteint la limite des lignes';


    procedure AcualFields()
    begin
    end;

    local procedure yearOnAfterValidate()
    begin
        Rec.SetFilter("Filtre Année", '%1', year);
        CurrPage.Update;
    end;
}

