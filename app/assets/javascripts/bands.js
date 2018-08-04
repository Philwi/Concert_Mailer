  $(document).on('click','#Band', function(){
    var id = this.value
    $('.js-lazy-load-band-edit').load("/bands/edit?id="+id)
  });
