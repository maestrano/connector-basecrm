class Entities::SubEntities::NotesMapper
  extend HashMapper

  map from('description'), to('content')
end
