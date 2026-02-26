Page 50232 "Integrer Payement BR à la cais"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Bon Reglement";
    SourceTableView = where(Statut = const(Validé),
                            Payer = const(false));
    ApplicationArea = all;
    Caption = 'Integrer Payement BR à la cais';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("N° Bon"; REC."N° Bon")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Integrer à la Caisse"; REC."Integrer à la Caisse")
                {
                    ApplicationArea = all;
                    Style = Strong;
                    StyleExpr = true;

                    trigger OnValidate()
                    begin
                        Integrer224laCaisseOnValidate;
                        Integrer224laCaisseOnAfterVali;
                    end;
                }
                field(Annee; REC.Annee)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Mois; REC.Mois)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Matricule; REC.Matricule)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Nom Et Prenom"; REC."Nom Et Prenom")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Nombre; REC.Nombre)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Jours Deplacement"; REC."Jours Deplacement")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Montant Deplacement"; REC."Montant Deplacement")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Divers; REC.Divers)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Net à Payer"; REC."Net à Payer")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Observation; REC.Observation)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Payer; REC.Payer)
                {
                    ApplicationArea = all;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        PayerOnAfterValidate;
                    end;
                }
            }
            field(TotBr; TotBr)
            {
                ApplicationArea = all;
                Caption = 'Total';
                DecimalPlaces = 3 : 3;
                Editable = false;
                Style = Unfavorable;
                StyleExpr = true;
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        GetSomme;
    end;

    var
        BonReg: record "Bon Reglement";
        TotBr: Decimal;
        NumCaisse: Code[20];
        NumLigneCaisse: Integer;
        RecPaymentLine: Record "Payment Line";
        Text001: label 'Voulez Integrer l''avance à La Ligne Caisse ?';
        Text002: label 'Integration Faite avec succée';


    procedure GetSomme()
    begin
        TotBr := 0;
        BonReg.SetRange(Statut, BonReg.Statut::Validé);
        BonReg.SetRange(Payer, false);
        if BonReg.FindFirst then
            repeat
                TotBr += BonReg."Net à Payer";
            until BonReg.Next = 0;
    end;


    procedure GetParametre(var codeCaisse: Code[20]; var NumLigne: Integer)
    begin
        NumCaisse := codeCaisse;
        NumLigneCaisse := NumLigne;
    end;

    local procedure Integrer224laCaisseOnAfterVali()
    begin
        Message('OK');
    end;

    local procedure Integrer224laCaisseOnValidate()
    begin
        if not Confirm(Text001, false) then begin
            REC."Integrer à la Caisse" := false;
            REC.Modify;
            exit;
        end;
        RecPaymentLine.Reset;
        if RecPaymentLine.Get(NumCaisse, NumLigneCaisse) then begin
            RecPaymentLine.Validate("Credit Amount", REC."Net à Payer");
            RecPaymentLine.Validate("Type Origine", 1);
            RecPaymentLine.Validate(Benificiaire, REC.Matricule);
            RecPaymentLine.Libellé := RecPaymentLine.Libellé + ' ' + REC."N° Bon";
            RecPaymentLine.Modify;
            REC.Payer := true;
            REC.Modify;
        end;

        CurrPage.Close;
    end;

    local procedure PayerOnAfterValidate()
    begin
        GetSomme;
        CurrPage.Update;
    end;
}

