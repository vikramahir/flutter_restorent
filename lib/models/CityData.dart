class CityData {
  int id;
  String name;
  int countryId;
  String countryName;
  String countryFlagUrl;
  int shouldExperimentWith;
  int hasGoOutTab;
  int discoveryEnabled;
  int hasNewAdFormat;
  int isState;
  int stateId;
  String stateName;
  String stateCode;

  CityData(
      {this.id,
        this.name,
        this.countryId,
        this.countryName,
        this.countryFlagUrl,
        this.shouldExperimentWith,
        this.hasGoOutTab,
        this.discoveryEnabled,
        this.hasNewAdFormat,
        this.isState,
        this.stateId,
        this.stateName,
        this.stateCode});

  CityData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryId = json['country_id'];
    countryName = json['country_name'];
    countryFlagUrl = json['country_flag_url'];
    shouldExperimentWith = json['should_experiment_with'];
    hasGoOutTab = json['has_go_out_tab'];
    discoveryEnabled = json['discovery_enabled'];
    hasNewAdFormat = json['has_new_ad_format'];
    isState = json['is_state'];
    stateId = json['state_id'];
    stateName = json['state_name'];
    stateCode = json['state_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['country_id'] = this.countryId;
    data['country_name'] = this.countryName;
    data['country_flag_url'] = this.countryFlagUrl;
    data['should_experiment_with'] = this.shouldExperimentWith;
    data['has_go_out_tab'] = this.hasGoOutTab;
    data['discovery_enabled'] = this.discoveryEnabled;
    data['has_new_ad_format'] = this.hasNewAdFormat;
    data['is_state'] = this.isState;
    data['state_id'] = this.stateId;
    data['state_name'] = this.stateName;
    data['state_code'] = this.stateCode;
    return data;
  }
}