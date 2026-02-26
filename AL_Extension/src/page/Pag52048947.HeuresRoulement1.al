
page 52048947 "Heures Roulement.1"
{ //GL2024  ID dans Nav 2009 : "39001502"
    AutoSplitKey = true;
    PageType = Card;
    SourceTable = "Heures sup. m";
    SourceTableView = sorting("Type heure", "N° Salarié", "N° Ligne", "Code departement", "Code dossier")
                      order(ascending)
                      where("Type heure" = const("Heure Sup."));
    ApplicationArea = all;
    UsageCategory = Administration;
    Caption = 'Heures Roulement.1';
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(dt; dt)
                {
                    ApplicationArea = Basic;
                    Caption = 'Date défaut';
                }
                field("Slr.""No."""; Slr."No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Filtre N° salarié';

                    trigger OnDrillDown()
                    begin
                        Clear(ListeSalarié);
                        if ListeSalarié.RunModal = Action::LookupOK
                          then begin
                            ListeSalarié.GetRecord(Slr);
                        end;
                        Rec.SetFilter("N° Salarié", Slr."No.");
                        CurrPage.Update;
                    end;
                }
            }
            repeater(Control1)
            {
                ShowCaption = false;
                field("N° Salarié"; Rec."N° Salarié")
                {
                    ApplicationArea = Basic;
                }
                field("Prénom +' '+""Nom usuel"""; Rec.Prénom + ' ' + Rec."Nom usuel")
                {
                    ApplicationArea = Basic;
                    Caption = 'Nom salarié';
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field("Type Jours"; Rec."Type Jours")
                {
                    ApplicationArea = Basic;
                }
                field(Semaine; Rec.Semaine)
                {
                    ApplicationArea = Basic;
                }
                field("Heure debut"; Rec."Heure debut")
                {
                    ApplicationArea = Basic;
                }
                field("Taux de majoration"; Rec."Taux de majoration")
                {
                    ApplicationArea = Basic;
                }
                // field("Nombre Heure Supp"; Rec."Nombre Heure Supp")
                // {
                //     ApplicationArea = Basic;
                // }
                field("Nombre d'heures"; Rec."Nombre d'heures")
                {
                    ApplicationArea = Basic;
                }
                field("Montant Ligne"; Rec."Montant Ligne")
                {
                    ApplicationArea = Basic;
                }
                field("Système"; Rec.Système)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Tarif unitaire"; Rec."Tarif unitaire")
                {
                    ApplicationArea = Basic;
                }
                field(Control1000000010; Rec."Type Jours")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Heure Fin"; Rec."Heure Fin")
                {
                    ApplicationArea = Basic;
                }
                field("Heures sup. enreg."; Rec."Heures sup. enreg.")
                {
                    ApplicationArea = Basic;
                }
                field("Mois de paiement"; Rec."Mois de paiement")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Année de paiement"; Rec."Année de paiement")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
            group(Control7)
            {
                ShowCaption = false;

                field("""Nom usuel"" + ' ' + Prénom"; Rec."Nom usuel" + ' ' + Rec.Prénom)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'Salarié';
                }
                field(Control25; Rec."Montant Ligne")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'Montant Ligne';
                }

                field("Salarié.""Heures sup."""; Salarié."Heures sup.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'Total heures sup.';
                }
            }
        }
    }

    actions
    {
        area(Promoted)
        {
            group("Fonction&s1")
            {
                Caption = 'Fonction&s';
                actionref("Impression test1"; "Impression test") { }
                actionref(Valider1; Valider) { }
            }
        }
        area(navigation)
        {
            group("Fonction&s")
            {
                Caption = 'Fonction&s';
                action("Impression test")
                {
                    ApplicationArea = Basic;
                    Caption = 'Impression test';
                    RunObject = Report "Tableau Amortissement Prêt @";
                }
                separator(Action16)
                {
                    Caption = '';
                }
                action(Valider)
                {
                    ApplicationArea = Basic;
                    Caption = 'Valider';
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    var
                        GRH: Codeunit "Management of Work Hours";
                        HeuresSup: Record "Heures sup. m";
                        HeuresSupTmp: Record "Heures sup. m";
                    begin
                        HeuresSup.Reset;
                        //CurrForm.SETSELECTIONFILTER(HeuresSup);
                        HeuresSup.CopyFilters(Rec);
                        GRH.Run(HeuresSup);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Salarié.Get(Rec."N° Salarié") then
            Salarié.CalcFields(Salarié."Heures sup.");
    end;

    trigger OnInit()
    begin
        dt := WorkDate;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Validate(Date, dt);
        Rec."Type heure" := Typej;
    end;

    trigger OnOpenPage()
    begin
        Typej := Rec.GetRangeMin("Type heure");
        if Typej = 0 then
            CurrPage.Caption := 'Heures Supp.'
        else
            CurrPage.Caption := 'Heures Roulement'
    end;

    var
        "Salarié": Record Employee;
        "PériodeCompta": Record "Accounting Period";
        "NomPériode": Text[30];
        dt: Date;
        GRH: Codeunit "Management of Work Hours";
        Slr: Record Employee;
        "ListeSalarié": Page "Employee List";
        Typej: Option "Heure Sup.",Roulement;
        Text19008931: label 'Salarié';
        Text19011937: label 'Total heures sup.';
}

