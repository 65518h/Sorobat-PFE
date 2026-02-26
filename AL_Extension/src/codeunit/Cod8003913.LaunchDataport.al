Codeunit 8003913 "Launch Dataport"
{

    trigger OnRun()
    begin
    end;


    /* //GL2024 NAVIBAT  procedure fLaunchNomad(var pSalesHeader: Record 36)
     var
        //GL2024 NAVIBAT   lNomad: xmlport 8003905;
       //GL2024 NAVIBAT    lXmlNomad: XmlPort 8003905;
     begin
         if (not ISSERVICETIER) then begin
             lNomad.SetDocument(pSalesHeader);
             lNomad.RunModal;
             if lNomad.Import then
                 lNomad.GetDocument(pSalesHeader);
         end else begin
             lXmlNomad.SetDocument(pSalesHeader);
             lXmlNomad.Run;
             if lXmlNomad.Import then
                 lXmlNomad.GetDocument(pSalesHeader);
         end;
     end;*/


    /*  //GL2024 NAVIBAT  procedure fLaunchAnalyticalRules()
      var
        //GL2024 NAVIBAT    lAnalyticalRules: xmlport 8003500;
       //GL2024 NAVIBAT     lXmlAnalyticalRules: XmlPort 8003500;
      begin
          if (not ISSERVICETIER) then begin
              lAnalyticalRules.RunModal;
          end else begin
              lXmlAnalyticalRules.Run;
          end;
      end;*/
}

