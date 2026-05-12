Page 50365 "Dialog fractionner ligne"
{
    Caption = 'fractionner ligne';
    PageType = StandardDialog;
    SourceTable = "Integer";
    SourceTableView = where(number = filter(1));

    layout
    {
        area(content)
        {
            field(MontantFR; MontantFR)
            {
                Caption = 'Montant a Fractionner';

            }
        }
    }

    procedure SetMontantFractionner(Montant: Decimal)
    begin
        MontantFR := Montant;


    end;

    procedure GetMontantFractionner(): Decimal
    begin
        exit(MontantFR);

    end;

    var
        MontantFR: Decimal;

}