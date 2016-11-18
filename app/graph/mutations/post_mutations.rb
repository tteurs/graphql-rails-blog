module PostMutations
  Create = GraphQL::Relay::Mutation.define do
    name "createPost"
    description "create Post"

    input_field :title, types.String
    input_field :content, types.String

    return_field :post, PostType
    return_field :errors, types[AttributeErrorType]

    resolve -> (obj, inputs, ctx) {
      new_post = User.last.posts.build(inputs.to_params)

      if new_post.save
        { post: new_post }
      else
        { errors: new_post.attributes_errors }
      end
    }
  end
end
