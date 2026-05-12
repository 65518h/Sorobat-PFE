
page 50343 "Heures Suppléméntaires"
{
    //GL2024  ID dans Nav 2009 : "39001427"
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Heures sup. m";
    SourceTableView = sorting("N° Ligne")
                      order(ascending);
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'Heures Suppléméntaires';
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
                field(Quinzaine; Rec.Quinzaine)
                {
                    ApplicationArea = Basic;
                }
                field("Type Jours"; Rec."Type Jours")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = true;
                }



                field("Nombre Jours Supp Maj 75%"; Rec."Nombre Jours Supp Maj 75%")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                // field("Nombre Heure Supp"; Rec."Nombre Heure Supp")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Heure Supp Majoré';
                // }

                field("Taux de majoration"; Rec."Taux de majoration")
                {
                    ApplicationArea = Basic;
                    Editable = false;


                }
                field("Nombre d'heures"; Rec."Nombre d'heures")
                {
                    ApplicationArea = Basic;
                }
                field("Heure debut"; Rec."Heure debut")
                {
                    ApplicationArea = Basic;
                }
                field("Heure fin"; Rec."Heure fin")
                {
                    ApplicationArea = Basic;
                }

                field("Montant Ligne"; Rec."Montant Ligne")
                {
                    ApplicationArea = Basic;
                    DecimalPlaces = 3 : 3;
                    Editable = false;
                }

                field("Année de paiement"; Rec."Année de paiement")
                {
                    ApplicationArea = Basic;
                }
                field("Mois de paiement"; Rec."Mois de paiement")
                {
                    ApplicationArea = Basic;
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


            actionref(Valider1; Valider) { }

        }
        area(navigation)
        {

            action("Impression test")
            {
                ApplicationArea = Basic;
                Caption = 'Impression test';
                RunObject = Report "Tableau Amortissement Prêt @";
                Visible = false;
            }
            separator(Action16)
            {
            }
            action(Valider)
            {
                ApplicationArea = Basic;
                Caption = 'Valider';
                ShortCutKey = 'F9';

                trigger OnAction()
                var
                    ManagementWorkHours: Codeunit "Management of Work Hours";
                    HeuresSup: Record "Heures sup. m";
                    HeuresSupTmp: Record "Heures sup. m";
                begin

                    HeureSupp2.Copy(Rec);
                    if HeureSupp2.FindFirst then
                        repeat
                            HeuresSupEnregistrée.SetRange("Mois de paiement", HeureSupp2."Mois de paiement");
                            HeuresSupEnregistrée.SetRange("Année de paiement", HeureSupp2."Année de paiement");
                            HeuresSupEnregistrée.SetRange("N° Salarié", HeureSupp2."N° Salarié");
                            HeuresSupEnregistrée.SetRange("Type Jours", HeureSupp2."Type Jours");
                            if HeuresSupEnregistrée.FindFirst then
                                Error(Text001, HeureSupp2."N° Salarié", HeureSupp2."Année de paiement"
                                       , HeureSupp2."Mois de paiement");
                        until HeureSupp2.Next = 0;


                    HeuresSup.Reset;
                    HeuresSup.CopyFilters(Rec);
                    ManagementWorkHours.Run(HeuresSup);
                end;
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

    var
        "Salarié": Record Employee;
        "PériodeCompta": Record "Accounting Period";
        "NomPériode": Text[30];
        dt: Date;
        ManagementWorkHours: Codeunit "Management of Work Hours";
        Slr: Record Employee;
        "ListeSalarié": Page "Employee List";
        Typej: Option "Heure Sup.",Roulement;
        Paramcpt: Record "General Ledger Setup";
        "HeuresSupEnregistrée": Record "Heures sup. eregistrées m";
        HeureSupp2: Record "Heures sup. m";
        Text001: label 'Heure Supp Deja Enregistré Pour Le Salarié %1, Année %2 , Mois %3';
        Text19008931: label 'Salarié';
        Text19011937: label 'Total heures sup.';
}

