public with sharing class MyPagingController {

    public String PageSize { get; set; }

    public String nextButtonDisabled { get; set; }

    public PageReference nextBtnClick() {
        return null;
    }


    public String previousButtonEnabled { get; set; }

    public PageReference previousBtnClick() {
        return null;
    }


    public String totalPageNumber { get; set; }

    public String PageNumber { get; set; }

    public String accounts { get; set; }

    public PageReference ViewData() {
        return null;
    }

}