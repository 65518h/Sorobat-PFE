Codeunit 8004002 Distance
{
    // //DISTANCE CW 27/05/03 Calcul de distance
    //                        Nécessite OCX "MathLibX Control"
    //                        Les coordonnées Lambert peuvent être mises à jour par le Dataport


    trigger OnRun()
    begin
    end;


    procedure Distance(pFrom: Code[10]; pTo: Code[10]) Return: Decimal
    var
        A: Record "Post Code";
        B: Record "Post Code";
        //GL2024 Automation non compatible   MathLib: Automation;
        Pi: Decimal;
        UnknownFrom: label 'Unknown From Code or Missing Data';
        UnknownTo: label 'Unknown To Code or Missing Data';
    begin
        Pi := 3.1415926535;
        A.SetRange(Code, pFrom);
        A.SetFilter(Latitude, '<>0');
        A.SetFilter(Longitude, '<>0');
        B.SetRange(Code, pTo);
        B.SetFilter(Latitude, '<>0');
        B.SetFilter(Longitude, '<>0');
        if not A.Find('-') or (A.Latitude = 0) or (A.Longitude = 0) then
            Error(UnknownFrom)
        else
            if not B.Find('-') or (B.Latitude = 0) or (B.Longitude = 0) then
                Error(UnknownTo);
        /*   //GL2024 Automation non compatible else begin
               if ISCLEAR(MathLib) then
                   Create(MathLib);
               Return :=
                 MathLib.Cos(A.Latitude * Pi / 180) *
                 MathLib.Cos(B.Latitude * Pi / 180) *
                 MathLib.Cos(B.Longitude * Pi / 180 - A.Longitude * Pi / 180) +
                 MathLib.Sin(A.Latitude * Pi / 180) * MathLib.Sin(B.Latitude * Pi / 180);*/
        /* //GL2024 Automation non compatible  if Abs(Abs(Return) - 1) < 0.000000000001 then // Avoid error
              Return := 0
          else
              Return := 6366 * MathLib.aCos(Return);*/
        // end;
    end;
}

