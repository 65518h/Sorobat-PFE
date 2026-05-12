Page 50264 "Heures sup. enregistrées 2"
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Heures sup. eregistrées m";
    SourceTableView = sorting("N° transaction", "N° Ligne", "N° Salarié")
                      order(ascending);

    ApplicationArea = all;
    Caption = 'Heures sup. enregistrées 2';
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Salarié.""No."""; Salarié."No.")
                {
                    ApplicationArea = all;
                    Caption = 'Filtre N° salarié';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        // MC : Filtre salarié

                        Clear(ListeSalarié);
                        ListeSalarié.LookupMode := true;
                        if ListeSalarié.RunModal = Action::LookupOK
                          then begin
                            ListeSalarié.GetRecord(Salarié);
                            //MESSAGE (Salarié.Prénom +' '+ Salarié."Nom usuel");
                        end;
                        REC.SetFilter("N° Salarié", Salarié."No.");
                        CurrPage.Update;
                    end;

                    trigger OnValidate()
                    begin
                        Salari233NoOnAfterValidate;
                    end;
                }
            }
            repeater(Control1)
            {
                Editable = false;
                ShowCaption = false;
                field("N° Ligne"; REC."N° Ligne")
                {
                    ApplicationArea = all;
                }
                field("Date comptabilisation"; REC."Date comptabilisation")
                {
                    ApplicationArea = all;
                }
                field("Paiement No."; REC."Paiement No.")
                {
                    ApplicationArea = all;
                }
                field("N° Salarié"; REC."N° Salarié")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Prénom +' ' + ""Nom usuel"""; REC.Prénom + ' ' + REC."Nom usuel")
                {
                    ApplicationArea = all;
                    Caption = 'Nom salarié';
                }
                field(Date; REC.Date)
                {
                    ApplicationArea = all;
                }
                field("Type Jours"; REC."Type Jours")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
                // field("Nombre Jours Supp"; REC."Nombre Jours Supp")
                // {
                //     ApplicationArea = all;
                // }
                // field("Nombre Heures Supp"; REC."Nombre Heures Supp")
                // {
                //     ApplicationArea = all;
                // }
                field("Montant Ligne"; REC."Montant Ligne")
                {
                    ApplicationArea = all;
                }
                field("Mois de paiement"; REC."Mois de paiement")
                {
                    ApplicationArea = all;
                }
                field("Année de paiement"; REC."Année de paiement")
                {
                    ApplicationArea = all;
                }
            }
            group(Control31)
            {
                ShowCaption = false;
                field(Control34; REC."N° Salarié")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Prénom +  ' ' + ""Nom usuel"""; REC.Prénom + ' ' + REC."Nom usuel")
                {
                    ApplicationArea = all;
                    Caption = 'Nom salarié';
                    Editable = false;
                }
                field(Control30; REC."Mois de paiement")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Control33; REC."Année de paiement")
                {
                    ApplicationArea = all;
                    Editable = false;
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
                actionref(Imprimer1; Imprimer) { }
                actionref(Devalider1; Devalider) { }
            }
        }
        area(navigation)
        {
            group("Fonction&s")
            {
                Caption = 'Fonction&s';
                Visible = false;
                action(Imprimer)
                {
                    ApplicationArea = all;
                    Caption = 'Imprimer';
                    Visible = false;

                    trigger OnAction()
                    begin
                        Report.Run(report::"Tableau Amortissement Prêt en@", true, false, Rec);
                    end;
                }
                action(Devalider)
                {
                    ApplicationArea = all;
                    Caption = 'Devalider';

                    trigger OnAction()
                    var
                        conf: label 'Are sur to unvalidate the selected lines.';
                        //GL3900     HeuresSup: Record "Heures sup. m";
                        Nligne: Integer;
                    begin
                        //GL3900 
                        /*    HeuresSup.Reset;
                            HeuresSup.SetCurrentkey("N° Ligne");
                            if HeuresSup.Find('+') then
                                Nligne := HeuresSup."N° Ligne" + 10000
                            else
                                Nligne := 10000;
    */ //GL3900 
                        CurrPage.SetSelectionFilter(Saved);
                        //Saved.SETFILTER("Paiement No.",'=''''');
                        Wind.Open('De validation de Heures Supplémentaire : \' +
                                  ' Salariée  #1########################### \' +
                                  ' N° Ligne              #2############### \' +
                                  ' Date Heure Supplémentaire  #3########## ');
                        if Saved.Find('-') then
                            if Confirm(conf) then
                                repeat
                                    Wind.Update(1, Saved."N° Salarié" + ' ' + Saved."Nom usuel");
                                    Wind.Update(2, Nligne);
                                    Wind.Update(3, Saved.Date);
                                    //GL3900    Hcode.DevaliderHeuresSup(Saved, Nligne);
                                    Nligne := Nligne + 10000;
                                until Saved.Next = 0;
                        Wind.Close;
                    end;
                }
            }
        }
    }

    var
        "Salarié": Record Employee;
        "ListeSalarié": Page "Employee List";
        Saved: Record "Heures sup. eregistrées m";
        //GL3900  Hcode: Codeunit "Management of Work Hours";
        Wind: Dialog;

    local procedure Salari233NoOnAfterValidate()
    begin
        REC.SetFilter("N° Salarié", Salarié."No.");
        CurrPage.Update;
    end;
}

