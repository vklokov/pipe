CREATE_ACTIVITY = {
  success: true,
  data: {
    id: 100,
    note: "Example note",
    subject: "Example subject",
    org_id: 123
  }
}

GET_PERSON = {
  success: true,
  data: {
    id: 1,
    name: 'Example Person',
    :'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa22' => 2,
    email: [{ id: 1, value: 'test@example.com', primary: true }],
    add_time: "2018-11-13 12:43:19",
    active_flag: true,
    org_id: {
      value: 1
    }
  }
}

GET_PERSON_WITHOUT_ORG = {
  success: true,
  data: {
    id: 2,
    name: 'Example Person 2',
    :'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa22' => 2,
    email: [{ id: 1, value: 'test@example.com', primary: true }],
    add_time: "2018-11-13 12:43:19",
    active_flag: true,
    org_id: nil
  }
}

GET_UPDATED_PERSON = {
  success: true,
  data: {
    id: 1,
    name: 'Example Person2',
    :'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa22' => 2,
    email: [{ id: 1, value: 'test@example.com', primary: true }],
    add_time: "2018-11-13 12:43:19",
    active_flag: true,
  }
}

GET_DELETED_PERSON = {
  success: true,
  data: {
    id: 1,
  }
}

GET_DEAL_FIELDS = {
  success: true,
  data: [
    {
      id: 1,
      key: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa11',
      name: 'Custom person field',
      field_type: 'enum',
      options: [
        {
          label: 'Option 1',
          value: 1
        },
        {
          label: 'Option 2',
          value: 2
        }
      ]
    }
  ]
}

GET_PERSON_FIELDS = {
  success: true,
  data: [
    {
      id: 1,
      key: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa22',
      name: 'Custom person field',
      field_type: 'enum',
      options: [
        {
          label: 'Option 1',
          id: 1
        },
        {
          label: 'Option 2',
          id: 2
        }
      ]
    },
    {
      id: 2,
      key: 'email',
      name: 'Email',
      field_type: 'varchar'
    },
    {
      id: 3,
      key: 'add_time',
      name: 'Creation date',
      field_type: 'date'
    }
  ]
}

GET_ORGANIZATION_FIELDS = {
  success: true,
  data: [
    {
      id: 1,
      key: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa33',
      name: 'Custom organization field',
      field_type: 'varchar',
    },
    {
      id: 2,
      key: 'name',
      name: 'Name',
      field_type: 'varchar'
    },
    {
      id: 3,
      key: 'add_time',
      name: 'Creation date',
      field_type: 'date'
    }
  ]
}

GET_ORGANIZATION = {
  success: true,
  data: {
    id: 1,
    name: 'Example Organization',
    add_time: "2018-11-13 12:43:19",
    active_flag: true,
    :'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa33' => 'foo'
  }
}
